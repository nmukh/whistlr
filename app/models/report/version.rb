class Report::Version < Report
  include Versions::LikeAVersion
  include Versions::LikeAVersionThatIsNested
  include Votes::Pollable
  include Votes::Voteable
  include Events::Eventable
  include Stat::Whistlr

  before_create :connect_with_master_associates
  after_create :assign_default_summary_to_participants, :follow_participants
  
  validates :participant_joins, presence: true, unless: :initial?
  validates :evidence_joins, presence: true, unless: :initial?

  add_event_to :user, :master, :officials, :organizations, :products

  def active_model_serializer
    ReportVersionSerializer
  end

  def assign_associations_to_master
    delete_removed_associations(:participants, :evidence)
    add_new_associations(:participants, :evidence)
  end

private

  def follow_participants
    participants.each do |participant|
      user.create_following_if_none(participant.reportable)
    end
  end

  def assign_default_summary_to_participants
    participants.each do |participant|
      summary = participant.summary.present? ? participant.summary : self.summary
      participant.update_column(:summary, summary)
    end
  end

  def connect_with_master_associates
    if initial?
      participants << master.participants
      evidence << master.evidence
    end
  end
end