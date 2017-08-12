class Zef < Formula
  desc "Perl6 Module Management"
  homepage "https://github.com/ugexe/zef"
  url "https://codeload.github.com/ugexe/zef/tar.gz/v0.1.26"
  sha256 "c6380acd70db5844264e6e814b3ea2d58eb9de7d5f942b44719ba1538ed66b48"

  head do
    url "https://github.com/ugexe/zef.git"
  end

  depends_on "rakudo"
  depends_on "perl" => :test

  def install
    ENV["RAKUDO_LOG_PRECOMP"] = "1"
    ENV["RAKUDO_RERESOLVE_DEPENDENCIES"] = "0"
    system "perl6-install-dist",
      "--to=#{prefix}/share/perl6/vendor",
      "--for=vendor",
      "--from=."
  end

  test do
    ENV["PERL6LIB"] = "lib"
    system "prove", "-r", "-e", "perl6"
  end
end
