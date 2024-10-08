require "rails_helper"

RSpec.describe 'Project show page', type: :feature do
    before(:each) do

    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
    end

  it "shows the theme of the challenge" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("News Chic")
    expect(page).to have_content("Newspaper")
    expect(page).to have_content("Recycled Material")
  end


  it "shows the number of contestants" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("2")
  end

  it "shows the average years of experience for the contestants" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Average years of xp of contestants: 12.5")
  end

  it 'has a form to add a contestant to a project' do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Add Contestant to Project")
    expect(page).to have_button("Add Contestant")
  end

  it 'can add a contestant to a project' do
    visit "/projects/#{@news_chic.id}"

    fill_in :contestant_id, with: @kentaro.id
    click_button "Add Contestant to Project"

    expect(current_path).to eq("/projects/#{@news_chic.id}")
    expect(page).to have_content('Number of contestants: 3')

    visit "/contestants"
    within "#contestant-#{@kentaro.id}" do
      expect(page).to have_content(@news_chic.name)
    end
    save_and_open_page
  end

end