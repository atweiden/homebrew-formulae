class Moarvm < Formula
  desc "A VM for NQP and Rakudo Perl 6"
  homepage "https://moarvm.org"
  url "https://moarvm.org/releases/MoarVM-2018.10.tar.gz"
  sha256 "acbaaa2695bbb5f2b965d65d0d1a947574efad7fe1af31237ed4e6b6b1225284"
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
