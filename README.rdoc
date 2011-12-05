Death And Taxes
===============

> "In this world nothing can be said to be certain, 
> except death and taxes." - Benjamin Franklin


Death And Taxes is a gem for ActiveRecord that makes it easier to handle Tax handling.


DeathAndTaxes
-------------

If you want to se the taxes that are in the config file, you can use DeathAndTaxes.applicable_taxes 

    DeathAndTaxes.applicable_taxes({:country => "ca", :state => "qc"}, {:country => "ca", :state => "qc"}, Date.today)
    #=> ["GST", "QST"]

To obtain the tax itself you can user DeathAndTaxes.build 

    DeathAndTaxes.build "QST", Date.today
    #=> #<DeathAndTaxes::Tax percentage: 8.5, name: "QST" ...>


Tax
---

The tax model should have a name and a percentage. You configure them in the config/#{country}.yml file if you wish to use the _DeathAndTaxes::applicable\_taxes_ method.

Taxes can be applied on another tax (like in Quebec before 2012) by having a tax itself.

You can obtain the effective rate of a tax (after being compounded) by using

    tax.multiplier

Taxable
-------

You can make ActiveRecord models taxable. The taxable models must respond to 'amount'


    class Product < ActiveRecord::Base
      acts_as_taxable
    end


Taxable models have a method apply_taxes which applies the correct taxes as taxations.

    product = Product.create :name => "Toto", :amount => 100
    product.apply_taxes [DeathAndTaxes::Tax.new(:name => "GST", :percentage => 7)]
    product.taxations
    #=> [#<DeathAndTaxes::Taxation amount: 7, percentage: 7.0, name: "GST" ...>]


Taxer
-----

Taxer model can have taxes associated. 
    
    class Organization < ActiveRecord::Base
      acts_as_taxer
    end
    
    organization.taxes << DeathAndTaxes::Tax.new(:name => "GST", :percentage => 7)


Testing
-------

    rspec spec/test_death_and_taxes.rb


Contributing to death_and_taxes
===============================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=========

Copyright (c) 2011 Guillaume Malette. See LICENSE.txt for
further details.

