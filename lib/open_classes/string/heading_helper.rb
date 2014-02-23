# encoding: utf-8
require 'active_support/core_ext/object/inclusion'

# HeadingHelper
module HeadingHelper
  # Space2
  SPACE2 = '  '

  private
    def to_heading
      self_chars = chars
      level, index, word_ret, ret = 0, 0, [], []
      self_chars.each_with_index do |v, index|
        key_word = v.in? %w{> + ^}

        if key_word
          ret << leveled_word(level, word_ret)
          level += v == '+' ? 0 : v == '>' ? 1 : -1
          word_ret = []
        else
          word_ret << v
        end
      end
      ret << leveled_word(level, word_ret)
    end

    def leveled_word(level, words)
      word = {}
      word[:level] = level
      word[:word] = words.join
      word
    end

    def to_head(heading, head_char)
      heading.reduce([]) { |ret, value|ret << "#{head_char * value[:level]}#{value[:word]}" }.join("\n")
    end
end