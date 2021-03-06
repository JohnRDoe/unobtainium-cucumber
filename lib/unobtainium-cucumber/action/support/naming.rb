# coding: utf-8
#
# unobtainium-cucumber
# https://github.com/jfinkhaeuser/unobtainium-cucumber
#
# Copyright (c) 2016-2017 Jens Finkhaeuser and other unobtainium-cucumber
# contributors. All rights reserved.
#
module Unobtainium
  module Cucumber
    module Action

      ##
      # Support functions for actions
      module Support

        ##
        # Given a cucumber scenario, this function returns a timestamped
        # base filename (without extension) that reflects parts of the scenario
        # name.
        # Note that the optional tag is not related to cucumber tags. It's just
        # a way to distinguish two filenames for the same scenario at the same
        # timestamp.
        # We use '_' as a replacement for unrenderable characters, and
        # '-' as a separator between file name components.
        def base_filename(scenario, tag = nil, timestamp = nil)
          # Build base name from parameters
          require 'time'
          timestamp ||= Time.now.utc.iso8601
          timestamp.tr!('-', '_')
          scenario_name = scenario.name
          base_name = [timestamp, tag, scenario_name].reject(&:nil?).join('-')

          # Make base name filename safe
          base_name.gsub!(%r{^.*(\\|/)}, '')
          base_name.gsub!(/[^0-9A-Za-z.\-]+/, '_')

          return base_name
        end

      end # module Support
    end # module Action
  end # module Cucumber
end # module Unobtainium
