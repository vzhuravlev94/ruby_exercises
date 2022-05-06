keys = ('a'..'z').to_a
vals = (1..26).to_a
alphabet = Hash[*keys.zip(vals).flatten]
alphabet_vowel = alphabet.select! {|k, v| %w[a e i o u y].include?(k)}
puts alphabet_vowel
