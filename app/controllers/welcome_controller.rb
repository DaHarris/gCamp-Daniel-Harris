class WelcomeController < ApplicationController

  def index

    @Cayla = ['Cayla Hayes', "gCamp has changed my life! It's the best tool I've ever used."];
    @Leta = ['Leta Jaskolski', "Before gCamp I was a disorderly slob. Now I'm more organized than I've ever been."];
    @Lavern = ['Lavern Upton', "Don't hesitate - sign up right now! You'll never be the same."];
    @QuoteArray = [@Cayla, @Leta, @Lavern];

  end

end
