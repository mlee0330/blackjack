# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'bust', =>  @trigger 'dealer-wins'
    @get('playerHand').on 'stand', =>  @get('dealerHand').dealersPlay()
    @get('dealerHand').on 'bust', =>  @trigger 'player-wins'
    @get('dealerHand').on 'stand', =>  @checkForWinnner()
  
  checkForWinnner: ->
    if @get('playerHand').maxScore() > @get('dealerHand').maxScore()
      @trigger 'player-wins'
    else if @get('playerHand').maxScore() < @get('dealerHand').maxScore()
      @trigger 'dealer-wins'
    else
      @trigger 'push'