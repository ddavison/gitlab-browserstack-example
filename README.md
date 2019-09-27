# Running Selenium Tests against BrowserStack using GitLab CI

> This project serves as a minimal example of how to run UI tests against BrowserStack
> through GitLab CI using the Selenium Ruby bindings.

There are essentially two pieces required to get GitLab CI working with BrowserStack.

  1. A `.gitlab-ci.yml` file
  1. BrowserStack Username / Access Key
  
## How it works

### [`spec/browserstack_spec.rb`]
In this example, [`spec/browserstack_spec.rb`] 
is the main piece and is an RSpec test file.

This file contains one essential piece to getting BrowserStack configured:

```ruby
let(:capabilities) do
  {
    browser: :chrome,
    browser_version: '77.0',
   os: 'OS X',
   os_version: 'Mojave',
   project: 'gitlab-browserstack-example',
   build: ENV['CI_JOB_ID']
 }
end
```

Here we are configuring the [Desired Capabilities](https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities)
for Selenium as well as BrowserStack.

You'll notice we are also specifying `ENV['CI_JOB_ID']`. This is a 
[pre-defined GitLab CI environment variable](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html) and it
is to differentiate each run by associating it with a GitLab Job.

Under the `capabilities` hash, we specify
[everything we'd like to configure BrowserStack](https://www.browserstack.com/automate/ruby) with.

- Username
- Access Key
- Tags / Name / Build for naming your build in BrowserStack

### [`.gitlab-ci.yml`]

Our [GitLab CI](https://docs.gitlab.com/ee/ci/README.html) configuration file contains one stage called `test`, that 
runs when we run the job manually.

> In an actual CI/CD environment, you'd most likely have `when:manual` removed, meaning that these
> tests will run against BrowserStack on every push / merge request to `master`.
>

[`spec/browserstack_spec.rb`]: https://gitlab.com/ddavison/gitlab-browserstack-example/tree/master/spec/browserstack_spec.rb
[`.gitlab-ci.yml`]: https://gitlab.com/ddavison/gitlab-browserstack-example/tree/master/.gitlab-ci.yml
