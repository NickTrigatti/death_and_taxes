class DeathAndTaxes::Taxes::Tax
  def initialize infos, options={}
    @start_date = Date.parse infos['start_date']
    @end_date = Date.parse infos['end_date']
  end
  
  def period
    @start_date..@end_date
  end
end