class Cxxbridge < Formula
  desc "C++ code generator for integrating cxx crate into a non-Cargo build"
  homepage "https://cxx.rs"
  url "https://crates.io/api/v1/crates/cxxbridge-cmd/1.0.79/download"
  sha256 "b5e4841817d774db9d271592b01029a280a6520b2bf72e8d87b56a710ebfd771"
  license "MIT, Apache-2.0"

  depends_on "rust" => :build

  def install
    system "tar", "xvf", "cxxbridge-cmd-#{version}.crate", "--strip-components=1"
    system "cargo", "install", *std_cargo_args
  end

  test do
    true
  end
end
