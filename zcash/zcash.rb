class Zcash < Formula
  desc "Implementation of the Zerocash protocol"
  homepage "https://z.cash/"
  url "https://github.com/zcash/zcash/archive/v4.7.0.tar.gz"
  sha256 "e5fa7c1749cd62d5cf36ccb1e1c6e4c41e9e7f3bae6ebf46e7b37c6968cc25d6"
  license "MIT"

  depends_on "berkeley-db@6.2.23"
  depends_on "boost"
  depends_on "libevent@2.1.12"
  depends_on "libsodium@1.0.18"
  depends_on "utf8cpp"

  depends_on "googletest" => :test

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "libtool" => :build
  depends_on "m4" => :build
  depends_on "pkg-config" => :build
  depends_on "rustup-init" => :build
  depends_on "gnu-which" => :build

  def install
    ENV.delete("SDKROOT") if MacOS.version == :el_capitan && MacOS::Xcode.version >= "8.0"

    ENV.append "CPPFLAGS", "-I#{Formula["berkeley-db@6.2.23"].include}"
    ENV.append "CPPFLAGS", "-I#{Formula["libevent@2.1.12"].include}"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium@1.0.18"].include}"
    ENV.append "CPPFLAGS", "-I#{Formula["utf8cpp"].opt_include}/utf8cpp"
    ENV.append "LDFLAGS", "-L#{Formula["berkeley-db@6.2.23"].lib}"
    ENV.append "LDFLAGS", "-L#{Formula["libevent@2.1.12"].lib}"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium@1.0.18"].lib}"

    ENV.append "PKG_CONFIG_PATH", ":#{Formula["libevent@2.1.12"].lib}/pkgconfig"
    ENV.append "PKG_CONFIG_PATH", ":#{Formula["libsodium@1.0.18"].lib}/pkgconfig"

    # prevent unnecessarily re-downloading rust toolchain
    ENV["CARGO_HOME"] = "#{HOMEBREW_CACHE}/cargo_cache"
    ENV["RUSTUP_HOME"] = "#{HOMEBREW_CACHE}/rustup_cache"

    # see: zcash/zcash/depends/packages/native_rust.mk
    system "rustup-init", "--no-modify-path", "-y"
    ENV.prepend_path "PATH", "#{HOMEBREW_CACHE}/cargo_cache/bin"
    system "rustup", "toolchain", "install", "1.59.0", "--profile", "minimal"
    system "rustup", "default", "1.59.0"

    ENV["RUST_TARGET"] = "x86_64-apple-darwin"
    ENV["CARGO_BUILD_TARGET"] = ENV["RUST_TARGET"]
    # credit: void-linux/void-packages//common/build-helper/rust.sh
    ENV["SODIUM_LIB_DIR"] = "#{Formula["libsodium@1.0.18"].include}"
    ENV["SODIUM_INC_DIR"] = "#{Formula["libsodium@1.0.18"].lib}"
    ENV["OPENSSL_NO_VENDOR"] = "1"

    system "./autogen.sh"
    system "./configure", "--disable-bench",
                          "--disable-ccache",
                          "--disable-man",
                          "--disable-static",
                          "--disable-tests",
                          "--disable-zmq",
                          "--enable-hardening",
                          "--enable-online-rust",
                          "--enable-reduce-exports",
                          "--with-boost-libdir=#{Formula["boost"].opt_lib}",
                          "--prefix=#{prefix}"
    system "make", "install"
    bin.install "zcutil/fetch-params.sh" => "zcash-fetch-params"
    pkgshare.install "share/rpcuser"
  end

  test do
    true
  end
end