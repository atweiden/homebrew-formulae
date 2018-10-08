class Moarvm < Formula
  desc "A VM for NQP and Rakudo Perl 6"
  homepage "https://moarvm.org"
  url "https://moarvm.org/releases/MoarVM-2018.09.tar.gz"
  sha256 "1a7f4363dee1feacc230928c81d280182d4d969398669bf145235f35b49f8fe7"
  head "https://github.com/MoarVM/MoarVM.git"

  depends_on "binutils" => :build
  depends_on "make" => :build
  depends_on "perl" => :build
  depends_on "pkg-config" => :build

  def install
    configure_args = [
      "--optimize",
      "--prefix=#{prefix}"
    ]
    system "perl", "Configure.pl", *configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/moar", "--version"
  end
end
