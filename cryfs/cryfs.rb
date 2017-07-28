require "open3"

class Cryfs < Formula
  desc "Cryptographic filesystem for the cloud"
  homepage "https://www.cryfs.org"
  url "https://github.com/cryfs/cryfs.git", tag: "0.9.7"
  head "https://github.com/cryfs/cryfs.git", branch: "develop"

  depends_on "cmake" => :build
  depends_on :python => :build
  depends_on "openssl"
  depends_on "boost"
  depends_on "cryptopp"
  depends_on :osxfuse

  needs :cxx11

  def install
    ncpu = `sysctl -n hw.ncpu`.to_i
    mkdir("build") do
      # TODO Homebrew is passing in CXXFLAGS to cmake which disable -O3.
      # TODO Can I make it build with -O3?
      system "cmake",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DBUILD_TESTING=off",
             "-DCRYFS_UPDATE_CHECKS=off",
             "..",
             *std_cmake_args
      system "make", "-j#{ncpu}"
      system "make", "install", "prefix=#{prefix}"
    end
  end

  test do
    Open3.popen3("#{bin}/cryfs") do |stdin, stdout, _|
      stdin.close
      assert_match "CryFS", stdout.read
    end
  end
end