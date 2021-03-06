# coding: utf-8
#
# unobtainium-cucumber
# https://github.com/jfinkhaeuser/unobtainium-cucumber
#
# Copyright (c) 2016-2017 Jens Finkhaeuser and other unobtainium-cucumber
# contributors. All rights reserved.
#

require 'unobtainium-cucumber/action/support/naming.rb'
require_relative './mocks/scenario'

Given(/^I have a scenario named (.+)$/) do |scenario|
  @action_support = {}
  @action_support[:scenario] = MockScenario.new(scenario)
end

Given(/^I provide a tag (.+)$/) do |tag|
  if tag == 'NIL'
    tag = nil
  end
  @action_support[:tag] = tag
end

Given(/^the timestamp is (\d+\-\d+\-\d+T\d+:\d+:\d+Z)$/) do |timestamp|
  @action_support[:timestamp] = timestamp
end

Then(/^I expect the filename to match (.+)/) do |expected|
  expected = Regexp.new(expected)

  tester = Class.new { extend ::Unobtainium::Cucumber::Action::Support }
  result = tester.base_filename(@action_support[:scenario],
                                @action_support[:tag],
                                @action_support[:timestamp])

  if not expected.match(result)
    raise "Result '#{result}' did not match expectation #{expected}!"
  end
end
