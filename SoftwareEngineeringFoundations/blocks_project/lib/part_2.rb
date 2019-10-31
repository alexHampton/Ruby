require "byebug"
def all_words_capitalized?(words)
    return words.all? { |word| word == word.capitalize}
end

def no_valid_url?(urls)
    validDomains = [".com", ".net", ".io", ".org"]
    noUrl = urls.none? do |url|
        # url.include?(".com") || url.include?(".net") || url.include?(".io") || url.include?(".org")
        validDomains.any? { |ending| url.end_with?(ending) }
    end
    noUrl
end

def any_passing_students?(students)
    students.any? do |student|
        avg = student[:grades].sum / (student[:grades].length * 1.0)
        avg >= 75
    end
end