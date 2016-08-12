class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.6.1.tar.gz"
  sha256 "a940123baa6c71b75b6c02836bae2155cd2f74f7682e1a1d6f7b889f7bc9e7f8"

  depends_on "cmake" => :build
  depends_on "make" => :build

  def install
    system "mkdir", "-p", "build"
    Dir.chdir("build")
    system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "../cmake_unofficial/"
    system "make", "all"
    system "make", "install"
  end

  test do
    true
  end
end
