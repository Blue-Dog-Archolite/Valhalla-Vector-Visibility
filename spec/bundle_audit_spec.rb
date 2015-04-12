require 'spec_helper'

describe 'keeps bundled gems up to date and detects vulnerabilities' do
  # update bundler audit
  it 'updates bundle audit\'s list of gems' do
    `bundle-audit update`
  end

  it 'expects security check to return No unpatched versions found' do
    output = `bundle-audit`
    expect(output).to match(/No unpatched versions found/i), lambda { "Bundler Audit Detected Security Vulnerabilities #{output}" }
  end
end

