class Moarvm < Formula
  desc "VM for NQP And Rakudo Perl 6"
  homepage "https://moarvm.org"
  url "https://moarvm.org/releases/MoarVM-2018.12.tar.gz"
  sha256 "e433a2a56953fca16ed8eaf9a597f25a7e1556436888609429f38529c241693b"
  head "https://github.com/MoarVM/MoarVM.git"

  depends_on "perl" => :build
  depends_on "pkg-config" => :build
  depends_on "libatomic_ops"
  depends_on "libffi"
  depends_on "libtommath"
  depends_on "libuv"

  def install
    libffi = Formula["libffi"]
    pkgconfig = Formula["pkgconfig"]
    ENV.remove "CPPFLAGS", "-I#{libffi.include}"
    ENV.prepend "CPPFLAGS", "-I#{libffi.lib}/libffi-#{libffi.version}/include"
    configure_args = [
      "--has-libatomic_ops",
      "--has-libffi",
      "--has-libtommath",
      "--has-libuv",
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
