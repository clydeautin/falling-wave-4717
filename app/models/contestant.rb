class Contestant < ApplicationRecord
    has_many :contestant_projects
    has_many :projects, through: :contestant_projects

    def project_list
        projects.pluck(:name).to_sentence
    end
end
