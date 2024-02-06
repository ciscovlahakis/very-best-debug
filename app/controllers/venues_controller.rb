class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/all_venues" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @venue = matching_venues.at(0)

    render({ :template => "venue_templates/venue_details" })
  end

  def create
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/#{venue.id}")
  end
  
  def update
    id = params.fetch("venue_id")
    @venue = Venue.find_by(id: id) # This finds a single venue or returns nil if not found
  
    # Make sure to check if @venue exists before attempting to update it
    if @venue
      @venue.address = params.fetch("query_address")
      @venue.name = params.fetch("query_name")
      @venue.neighborhood = params.fetch("query_neighborhood")
      @venue.save
      
      redirect_to("/venues/#{@venue.id}")
    else
      # Handle the case where the venue was not found
      redirect_to("/venues", alert: "Venue not found.")
    end
  end  

  def destroy
    id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
