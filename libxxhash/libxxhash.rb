class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.6.2.tar.gz"
  sha256 "e4da793acbe411e7572124f958fa53b280e5f1821a8bf78d79ace972950b8f82"

  depends_on "cmake" => :build

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
