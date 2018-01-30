require_relative "./test_helper"

class BootstrapErrorsTest < ActionView::TestCase
  include BootstrapForm::Helper

  setup :setup_test_fixture

  test "invalid-feedback in correct placement in input-group" do
    @user.email = nil
    assert @user.invalid?

    output = bootstrap_form_for(@user) do |f|
      f.text_field(:email, prepend: '1', append: '2')
    end

    expected = <<-HTML.strip_heredoc
      <form accept-charset="UTF-8" action="/users" class="new_user" id="new_user" method="post" role="form">
        <input name="utf8" type="hidden" value="&#x2713;" />
        <div class="form-group">
          <label class="required" for="user_email">Email</label>
          <div class="input-group">
            <div class="input-group-prepend"><span class="input-group-text">1</span></div>
            <input class="form-control is-invalid" id="user_email" name="user[email]" type="text"/>
            <div class="input-group-append"><span class="input-group-text">2</span></div>
            <div class="invalid-feedback">can't be blank, is too short (minimum is 5 characters)</div>
          </div>
        </div>
      </form>
    HTML
    assert_equivalent_xml expected, output
  end

end
