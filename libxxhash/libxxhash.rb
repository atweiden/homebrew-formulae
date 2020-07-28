class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.8.0.tar.gz"
  sha256 "7054c3ebd169c97b64a92d7b994ab63c70dd53a06974f1f630ab782c28db0f4f"
  head "https://github.com/Cyan4973/xxHash.git"
  license "BSD-2-Clause"

  def install
    system "make", "lib"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    true
  end
end
