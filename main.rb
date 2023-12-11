require 'set'

def read_file filename
    sentences = []
    File.open(filename).each_line do |line|
        sentences << line.split
    end
    return sentences
end

def read_file_set filename
    set = Set.new
    File.open(filename).each_line do |line|
        set << line.strip
    end
    return set
end

$stopwords = read_file_set('stopwords.txt')

def stopword? word
    return $stopwords.include? word.downcase
end

def punc? word
    return /^(\.|;|\?|!|\.|&|\(|\)|,|'|\"|`|\-|\—)+$/.match(word)
end


def main sentfile, stopfile
    sentences = read_file sentfile

    puts "total number of sentences #{sentences.size}"

    puts "total number of words #{sentences.flatten.size}"

    puts "how many words are punctuation? #{sentences.flatten.count{ |w| punc? w}}"

    puts "how many words are 'stop words'? #{sentences.flatten.count{ |w| stopword? w}}"

    puts "how many sentences do not contain at least one stop word? #{sentences.filter{ |s| s.filter { |w| stopword?(w)}.size == 0 }.size}"

    puts "first sentence without any stop words: #{sentences.filter{ |s| s.filter { |w| stopword?(w)}.size == 0 }[0].join(' ')}"
end

if __FILE__ == $0
    main 'wwo.txt', 'stopwords.txt'
end