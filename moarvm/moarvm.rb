class Moarvm < Formula
  desc "VM for NQP And Rakudo Perl 6"
  homepage "https://moarvm.org"
  url "https://moarvm.org/releases/MoarVM-2018.11.tar.gz"
  sha256 "b0f378fb72dac6fa2af2ab9c0dbd8012fb9bc43d223a7583c4ecb68b17ffa7ea"
  head "https://github.com/MoarVM/MoarVM.git"

  depends_on "make" => :build
  depends_on "perl" => :build
  depends_on "pkg-config" => :build
  depends_on "libatomic_ops"
  depends_on "libffi"
  depends_on "libtommath"
  depends_on "libuv"

  def install
    libffi = Formula["libffi"]
    make = Formula["make"]
    pkgconfig = Formula["pkgconfig"]
    ENV.remove "CPPFLAGS", "-I#{libffi.include}"
    ENV.prepend "CPPFLAGS", "-I#{libffi.lib}/libffi-#{libffi.version}/include"
    configure_args = [
      "--has-libatomic_ops",
      "--has-libffi",
      "--has-libtommath",
      "--has-libuv",
      "--make=#{make.bin}/gmake",
      "--optimize",
      "--pkgconfig=#{pkgconfig.bin}/pkg-config",
      "--prefix=#{prefix}",
    ]
    system "perl", "Configure.pl", *configure_args
    system "make", "realclean"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/moar", "--version"
  end
end
