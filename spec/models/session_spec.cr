require "./spec_helper"
require "../../src/models/session.cr"

describe Session do
  Spec.before_each do
    Session.clear
  end
end
