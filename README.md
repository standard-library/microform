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

## Usage

 The `Microform::Submission` is a controller mixin. It provides a `submit` method that will better isolate your form tests by allowing form submission to be easily stubbed out in controller tests. Include it in the relevant controller for your form(s):

```ruby
  class ApplicationController < ActionController::Base
    include Microform::Submission
  end
```

A generated Microform form provides an interface that initializes a record and defines a submit method:

```ruby
  class PostForm
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def submit(changeset)
      post.assign_attributes(changeset)
      return false unless valid?
      post.save
    end
  end
  ```

Since methods are passed to the record in the form, you can use the form object in your views and can supply the form to Rails' form helpers directly.

In the controller where you want to use the form, instantiate the new form in your actions with a record. You can save the record using the `submit` method, providing the form name, record, and changeset:

```ruby
  class PostsController < ApplicationController
    def new
      @post = Post.new
      @post_form = PostForm.new @post
    end

    def edit
      @post_form = PostForm.new @post
    end

    def create
      @post = Post.new
      @post_form = submit PostForm, @post, post_params

      if @post_form.valid?
        redirect_to post_url @post_form
      else
        render :new
      end
    end

    def update
      @post_form = submit PostForm, @post, post_params

      if @post_form.valid?
        redirect_to post_url @post_form
      else
        render :edit
      end
    end
  end
```

## Generating Forms

Generate a form for your model, with accompanying tests:

```
  rails g microform:form model_name
```

This will create two files: `app/forms/model_name_form.rb` and `test/forms/model_name_test.rb`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/standard-library/microform. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Microform project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/microform/blob/master/CODE_OF_CONDUCT.md).
