require 'rails_helper'

RSpec.describe Thing::Create, type: :operation do
  # it { is_expected.to be_a_trailblazer_operation }
  # it { is_expected.to use_model Thing }

  describe "Create" do
    it "rendering" do
      form = Thing::Create.present({}).contract
      form.prepopulate!

      expect(form.users.size).to eq(3)
      expect(form.users[0].email).to be_nil
      expect(form.users[1].email).to be_nil
      expect(form.users[2].email).to be_nil
    end

    it "persists valid" do
      thing = Thing::Create.(thing: {name: "Rails", description: "Kickass web dev"}).model

      expect(thing.persisted?).to be_truthy
      expect(thing.name).to eq('Rails')
      expect(thing.description).to eq('Kickass web dev')
    end

    it 'rejects invalid name' do
      res, op = Thing::Create.run(thing: {name: ""})
      expect(res).to be_falsey
      expect(op.model.persisted?).to be_falsey
      expect(op.contract.errors.to_s).to eq "{:name=>[\"doit être rempli(e)\"]}"
    end

    it 'rejects invalid description' do
      res, op = Thing::Create.run(thing: {name: "Rails", description: "hi"})
      expect(res).to be_falsey
      expect(op.contract.errors.to_s).to eq "{:description=>[\"est trop court (au moins 4 caractères)\"]}" 
    end


    # FILE UPLOAD
    it 'valid upload' do
      # thing = Thing::Create.call(thing: {name: "Rail", file: File.open("spec/images/cells.jpg")}).model
      thing = Thing::Create.call(thing: {name: "Rail", file: fixture_file_upload("cells.jpg", "image/jpeg")}).model

      expect(Paperdragon::Attachment.new(thing.image_meta_data).exists?).to be_truthy
    end

    it "hack" do
      thing = Thing::Create.(thing: {name: "Rails",
        image_meta_data: {bla: 1}}).model
      
      expect(thing.image_meta_data).to be_nil
    end

    it "invalid upload" do
      res, op = Thing::Create.run(thing: {name: "Rails",
        file: fixture_file_upload("hack.pdf")})

      expect(res).to be_falsey
      # expect(op.errors.to_s).to eq "{:file=>[\"file has an extension that does not match its contents\", \"file should be one of image/jpeg, image/png\"]}"
      expect(op.errors.to_s).to eq "{:file=>[\"translation missing: fr.activemodel.errors.models.thing.attributes.file.allowed_file_content_types\"]}"
    end    


    # USERS
    it 'rejects invalid users email' do
      res, op = Thing::Create.run(thing: {
        name: Rails,
        users: [{"email" => "invalid format"},
                {"email" => "bla"}]
      })

      expect(res).to be_falsey
      expect(op.errors.to_s).to eq "{:\"users.email\"=>[\"n'est pas valide\"]}"

      form = op.contract
      form.prepopulate!

      expect(form.users[0].email).to eq "invalid format"
      expect(form.users[1].email).to eq "bla"
      expect(form.users[2].email).to be_nil
    end

    it 'all email blank' do
      res, op = Thing::Create.run(thing: { name: "Rails", users: [{email: ""}] })
      
      expect(res).to be_truthy
      expect(op.model.users).to eq([])
    end

    it 'valid, new and existing email' do
      solnic = User::Create.(user: {email: "solnic@trb.org"}).model
      expect(User.count).to eq(1)

      op = Thing::Create.call(thing: {
        name: "Rails",
        users: [{"email" => "solnic@trb.org"}, {"email" => "nick@trb.org"}]
      })
      thing = op.model

      expect(thing.users.size).to eq(2)
      expect(thing.users[0].attributes.slice("id", "email")).to eq("id" => solnic.id, "email" => "solnic@trb.org")
      expect(thing.authorships.pluck(:confirmed)).to eq([0, 0])

      expect(op.invocations[:default].invocations[0]).to eq [:on_add, :notify_author!, [op.contract.users[0], op.contract.users[1]]]
    end

    it"users>3"do
      emails = 4.times.collect { |i| {"email"=>"#{i}@trb.org"} }
      res, op = Thing::Create.run(thing: {name: "Rails", users: emails})

      expect(res).to be_falsey
      expect(op.errors.to_s).to eq "{:users=>[\"est trop long (pas plus de 3 caractères)\"]}"
    end

    it do
      5.times { |i| Thing::Create.(thing: {name: "Rails #{i}", users: [{"email"=>"nick@trb.org"}]}) }
      res, op = Thing::Create.run(thing: {name: "Rails", users: [{"email"=>"nick@trb.org"}]})

      expect(res).to be_falsey
      expect(op.errors.to_s).to eq "{:\"users.user\"=>[\"This user has too many unconfirmed authorships.\"]}"
    end
  end


  describe "Update" do
    let (:thing) { Thing::Create.(thing: {name: "Rails", description: "Kickass web dev", users: [{"email"=>"solnic@trb.org"}]}).model }

    it "rendering" do
      form = Thing::Update.present({id: thing.id}).contract
      form.prepopulate!

      expect(form.users.size).to eq(3)
      expect(form.users[0].email).to eq("solnic@trb.org")
      expect(form.users[1].email).to be_nil
      expect(form.users[2].email).to be_nil
    end

    it "persists valid thing, ignores name" do
      Thing::Update.(
        id: thing.id,
        thing: {
          name: "Lotus",
          description: "Simply better…"
        }
      )

      thing.reload
      expect(thing.name).to eq "Rails"
      expect(thing.description).to eq "Simply better…"
    end

    it "valid, new and existing email" do
      solnic = thing.users[0]
      model = Thing::Update.call(id: thing.id, thing: {"users" => [{"id": solnic.id, "email" => "solnicxxx@trb.org"}, {"email" => "nick@trb.org"}]}).model

      expect(model.users.size).to eq(2)
      expect(model.users[0].attributes.slice("id", "email")).to eq("id" => solnic.id, "email" => "solnic@trb.org")
      expect(model.users[1].email).to eq("nick@trb.org")
      expect(model.users[1].persisted?).to be_truthy
    end

    it "doesn't allow changing existing email" do
      model = Thing::Update.(id: thing.id, thing: {users: [{"email" => "wrong@nerd.com"}]}).model

      expect(model.users[0].email).to eq "solnic@trb.org"
    end

    it "all emails blank" do
      op = Thing::Create.call(thing: {name: "Rails", users: []})

      res, op = Thing::Update.run(id: op.model.id, thing: {name: "Rails", users: [{"email"=>""}, {"email"=>""}]})

      expect(res).to be_truthy
      expect(op.model.users).to eq []
    end

    it "allows removing" do
      pending

      op  = Thing::Create.(thing: {name: "Rails  ", users: [{"email"=>"joe@trb.org"}]})
      joe = op.model.users[0]

      res, op = Thing::Update.run(id: op.model.id, thing: {name: "Rails", users: [{"id"=>joe.id.to_s, "remove"=>"1"}]})

      expect(res).to be_truthy
      expect(op.model.users).to eq []
      expect(joe.persisted?).to be_truthy
    end
  end
end

