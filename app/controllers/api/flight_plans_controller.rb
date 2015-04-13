module Api
  class FlightPlansController < ApplicationController

    def index
      @chart = Gchart.line(data: [300, 100, 30, 200, 100, 200, 300, 10],
                           axis_with_labels: 'x,r',
                           axis_labels: ['Jan|July|Jan|July|Jan', '2005|2006|2007'],
                           legend: ['Yep'])

      @forecast = [{fuck: 'you'}]

      #render :json => {chart: chart}.to_json
    end
  end
end
