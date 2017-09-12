class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.6.3.tar.gz"
  sha256 "d8c739ec666ac2af983a61dc932aaa2a8873df974d333a9922d472a121f2106e"

  depends_on "cmake" => :build

  def install
    system "mkdir", "-p", "build"
    Dir.chdir("build")
    system "cmake",
           "-DCMAKE_INSTALL_PREFIX=#{prefix}",
           "-DBUILD_SHARED_LIBS=ON",
           "../cmake_unofficial/"
    system "make", "all"
    system "make", "install"
  end

  test do
    true
  end
end
