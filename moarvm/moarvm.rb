class Moarvm < Formula
  desc "A VM for NQP and Rakudo Perl 6"
  homepage "https://moarvm.org"
  url "https://moarvm.org/releases/MoarVM-2018.11.tar.gz"
  sha256 "b0f378fb72dac6fa2af2ab9c0dbd8012fb9bc43d223a7583c4ecb68b17ffa7ea"
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
