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
    describe 'within Quebec' do
      {2011 => 8.5, 2012 => 9.5}.each do |year, percentage|
        it "in #{year}" do
          date = Date.new(year,01,01)
          taxes =  applicable_taxes({:state => "qc"}, {:state => "qc"}, 
              date).map{|name| DeathAndTaxes::build name, date}
                    
          taxes.first.name.should == "GST"
          taxes.first.percentage.should == 5.0
    
          taxes.last.name.should == "QST"
          taxes.last.percentage.should == percentage
        end
      end
    end
    
    it 'from Quebec to Ontario, in 2011' do
      date = Date.new(2011,01,01)
      taxes =  applicable_taxes({:state => "qc"}, {:state => "on"}, 
          date).map{|name| DeathAndTaxes::build name, date}
      
      taxes.length.should == 1
      
      taxes.first.name.should == "GST"
      taxes.first.percentage.should == 5.0
    end
    
    it 'from Ontario to Quebec, in 2011' do
      date = Date.new(2011,01,01)
      taxes =  applicable_taxes({:state => "on"}, {:state => "qc"}, 
          date).map{|name| DeathAndTaxes::build name, date}
      
      taxes.length.should == 1
      taxes.first.name.should == "HST"
      taxes.first.percentage.should == 13
    end
  end
  
end
