load './CreditCardHistory/NetAnswer.rb'

class CreditCardHistory

  @netanswer

  def call
    @netanswer ||= NetAnswer.new
    @netanswer.call
  end
  
end