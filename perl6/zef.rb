class Zef < Formula
  desc "A Perl 6 module manager"
  homepage "https://github.com/ugexe/zef"
  url "https://github.com/ugexe/zef/archive/v0.5.3.tar.gz"
  sha256 "71679926211d06a52dd2be83295ec4028d5cdbd4228fed896de3935c7a4a4903"

  head do
    url "https://github.com/ugexe/zef.git"
  end

  depends_on "curl"
  depends_on "git"
  depends_on "gnu-tar"
  depends_on "perl"
  depends_on "rakudo"
  depends_on "unzip"
  depends_on "wget"
  depends_on "rakudo" => :build
  depends_on "perl" => :test

  def install
    ENV["RAKUDO_LOG_PRECOMP"] = "1"
    ENV["RAKUDO_RERESOLVE_DEPENDENCIES"] = "0"
    system "perl6-install-dist",
      "--to=#{prefix}/share/perl6/vendor",
      "--for=vendor",
      "--from=."
    # symlink zef in share/perl6/site/bin
    bin.install_symlink Dir[share/"perl6/vendor/bin/*"]
  end

  test do
    ENV["PERL6LIB"] = "lib"
    system "prove", "-r", "-e", "perl6", "t/"
  end
end
