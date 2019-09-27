# frozen_string_literal: true

require 'selenium-webdriver'

describe 'GitLab' do
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

  let(:url) do
    "http://#{ENV['BROWSERSTACK_USERNAME']}:#{ENV['BROWSERSTACK_ACCESS_KEY']}@hub-cloud.browserstack.com/wd/hub"
  end

  let(:driver) do
    Selenium::WebDriver.for :remote,
                            url: url,
                            desired_capabilities: capabilities
  end

  after do
    driver.quit
  end

  it 'works with BrowserStack' do
    driver.get('https://www.google.com/ncr')
    driver.find_element(name: 'q').send_keys 'gitlab browserstack', :return
    expect(driver.title).to eq('gitlab browserstack - Google Search')
  end
end
