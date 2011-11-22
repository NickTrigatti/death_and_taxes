require 'helper'

describe 'DeathAndTaxes' do
  describe 'should find the correct taxes' do
    it 'within Quebec, in 2011' do
      applicable_taxes({:state => "qc"}, {:state => "qc"}, 
        Date.new(2011,01,01)).should == ["GST", "QST"]
    end
    
    it 'within Quebec, in 2012' do
      applicable_taxes({:state => "qc"}, {:state => "qc"}, 
        Date.new(2012,01,01)).should == ["GST", "QST"]
    end
    
    it 'within Ontario, in 2011' do
      applicable_taxes({:state => "on"}, {:state => "on"}, 
        Date.new(2011,01,01)).should == ["HST"]
    end
    
    it 'from Ontario to Quebec, in 2011' do
      applicable_taxes({:state => "on"}, {:state => "qc"}, 
        Date.new(2011,01,01)).should == ["HST"]
    end
  end
  
  describe 'should build the correct taxes' do
    it 'within Quebec, in 2011'
    
    it 'within Quebec, in 2012'
    it 'within Ontario, in 2011'
    
    it 'from Quebec to Ontario, in 2011'
  end
  
end
