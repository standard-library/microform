# Microform

[![Build Status](https://travis-ci.org/standard-library/microform.svg?branch=master)](https://travis-ci.org/standard-library/microform)
[![Gem Version](https://badge.fury.io/rb/microform.svg)](https://badge.fury.io/rb/microform)

Microform creates forms for you to use in your Rails 5+ applications, minimally applying the form object pattern.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'microform'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install microform

## Generating Forms

Generate a form for your model, with accompanying tests:

```
  rails g microform:form model_name
```

This will create two files: `app/forms/model_name_form.rb` and `test/forms/model_name_test.rb`.

## Usage

 The `Microform::Submission` module provides a `submit` method that will help to better isolate your form tests. Include it in the relevant controller for your form(s):

```ruby
  class AdminController < ApplicationController
    include Microform::Submission
  end
```

Then, in the controller where you want to use the form, instantiate the new form in your actions with a model instance. You can save or update attributes using the `submit` method, providing the form name, instance, and the parameters:

```ruby
  def new
    @post = Post.new
    @post_form = PostForm.new(@post)
  end

  def edit
    @post_form = PostForm.new(@post)
  end

  def create
    @post = Post.new
    @post_form = submit(PostForm, @post, post_params)

    respond_to do |format|
      if @post_form.valid?
        format.html { redirect_to admin_post_url(@post_form), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post_form }
      else
        format.html { render :new }
        format.json { render json: @post_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post_form = submit(PostForm, @post, post_params)

    respond_to do |format|
      if @post_form.valid?
        format.html { redirect_to admin_post_url(@post_form), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_form }
      else
        format.html { render :edit }
        format.json { render json: @post_form.errors, status: :unprocessable_entity }
      end
    end
  end
```

The form objects are duck-typed to quack like the model instance by leveraging the `method_missing` method. So if you have simple model without complicated attributes, then you can probably use Microform right out of the box.

If your model does have complicated attributes, then you will probably want to go into the generated form and tweak the `submit` method.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/standard-library/microform. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Microform project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/microform/blob/master/CODE_OF_CONDUCT.md).
