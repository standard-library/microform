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

A Microform form provides an interface that initializes with a record and defines a submit method:

```ruby
class PostForm
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def submit(changeset)
    post.update(changeset)
  end
end
```

Since methods are passed to the record in the form, you can use the form object in your views and can supply the form to Rails' form helpers directly.

`Microform::Submission` is a controller mixin. It provides a `submit` method that will better isolate your form tests by allowing form submission to be easily stubbed out in controller tests. Include it in the relevant controller for your form(s):

```ruby
class ApplicationController < ActionController::Base
  include Microform::Submission
end
```

In the controller where you want to use the form, instantiate the new form in your actions with a record. You can save the record using the `submit` method, providing the form class, record, and changeset:

```ruby
class PostsController < ApplicationController
  def new
    @post = Post.new
    @post_form = PostForm.new @post
  end

  def edit
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    @post_form = submit PostForm, @post, post_params

    if @post_form.valid?
      redirect_to post_url @post_form
    else
      render :edit
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
```

## Generating Forms

Generate a form for your model, with accompanying tests:

```
rails g microform:form model_name
```

This will create two files: `app/forms/model_name_form.rb` and `test/forms/model_name_test.rb`.

## Testing

### Forms

Because form objects are plain Ruby objects, you can test them without much fuss. The first test you might write is submitting a form with no new attributes provided. Because the `submit` method returns a boolean, you can pass the return value directly to `assert`.

```ruby
class PostFormTest < ActiveSupport::TestCase
  test "should submit form" do
    post = posts(:one)
    changeset = {}
    form = PostForm.new(post)

    assert form.submit(changeset)
  end
end
```

Other tests could cover submitting certain attributes and ensuring that the record is updated correctly.

### Controllers

Using the form object pattern allows you to extract tests that cover updating records from your controller/integration tests. This keeps the tests that cover your controllers and routing focussed on those concerns specifically. If code is introduced that breaks form submission, only the form object tests will fail, making your application easier to debug.

Microform provides a `Microform::TestMethods` module for asserting and stubbing form submissions with Minitest.

```ruby
require 'test_helper'
require 'microform/test_methods'

class Admin::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should create post" do
    post = posts(:one)
    valid_double = OpenStruct.new(post: post)

    assert_submits PostForm, stub: valid_double do
      post posts_url, params: { title: "Foo" }
      # ^ params must still be valid for strong_params, but they are not used
      #   if the form object has been stubbed, as in this example.
      assert_redirected_to posts_url(post)
    end
  end
end
```

The `stub` value specifies a return value from the controller's `submit` method. This is optional, and you may omit it in the case that you want the original behavior to be run but still assert that a specific kind of form was submitted.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/standard-library/microform. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Microform project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/microform/blob/master/CODE_OF_CONDUCT.md).
