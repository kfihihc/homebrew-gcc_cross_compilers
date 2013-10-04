require 'formula'

class I586ElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz'
  sha1 '470c388c97ac8d216de33fa397d7be9f96c3fe04'

  def install
    ENV['CC'] = '/usr/bin/gcc'
    ENV['CXX'] = '/usr/bin/g++'
    ENV['CPP'] = '/usr/bin/cpp'
    ENV['LD'] = '/usr/bin/gcc'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i586-elf',
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
