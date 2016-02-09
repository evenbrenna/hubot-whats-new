chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'whats-new', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/whats-new')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/(what.?s new in) (.+)/i)
