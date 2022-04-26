require 'debug'

score = ARGV[0]

scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  if shot == [10, 0]
    frames << [shot.shift]
  else
    frames << shot
  end
  if frames[10]
    frames[9].concat(frames[10])
  end
  if frames[11]
    frames[9].concat(frames[11])
  end
  frames.slice!(10, 11)
end

point = 0
frames.each_with_index do |frame, i|
  case i
  when 0..7
    if frame[0]==10 && frames[i+1][0]==10 #ストライクが２回連続
      point += 10 + 10 + frames[i+2][0] #確認OK
    elsif frame[0]==10 #ストライクが１回のみ
      point += 10 + frames[i+1][0] + frames[i+1][1]
    elsif  frame.sum == 10 && frame[0]!=10 #スペア
      point += 10 + frames[i+1][0]#OK
    else
      point += frame.sum
    end
  when 8
    if frame[0]==10 #ストライク
      point += 10 + frames[i+1][0] + frames[i+1][1]
    elsif  frame.sum == 10 #スペア
      point += 10 + frames[i+1][0]
    else
      point += frame.sum
    end
  when 9..11
    point += frame.sum
  end
end

puts point
