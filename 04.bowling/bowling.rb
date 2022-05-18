require 'debug'

#ボウリングの結果データをコマンドからを取得
def main
  get_score = ARGV[0]
  scores = get_score.split(',')
  make_array(scores)
end

#受け取ったデータを配列に収める
def make_array(scores)
  shots = scores.flat_map do |score|
    if score == 'X'
      [10,0]
    else
      score.to_i
    end
  end
  arrange_array(shots)
end

#配列をフレームにごとに分割
def arrange_array(shots)
  frames_div = shots.each_slice(2).map do |shot|
    if shot == [10, 0]
      [shot.shift]
    else
      shot
    end
  end

  #投球数が変則的な場合の処理
  frames = []
  frames_div.each do |arrange|
    frames << arrange
    if frames[10]
      frames[9].concat(frames[10])
    end
    if frames[11]
      frames[9].concat(frames[11])
    end
    frames.slice!(10, 11)
  end
  add_point(frames)
end

#スコア計算
def add_point(frames)
  point = 0
  frames.each_with_index do |frame, i|
    case i
    when 0..7 #8ラウンド目まで
      if frame[0]==10 && frames[i+1][0]==10 #ストライクが２回連続
        point += 10 + 10 + frames[i+2][0]
      elsif frame[0]==10 #ストライクが１回のみ
        point += 10 + frames[i+1][0] + frames[i+1][1]
      elsif  frame.sum == 10 && frame[0]!=10 #スペア
        point += 10 + frames[i+1][0]
      else
        point += frame.sum
      end
    when 8 #9ラウンド目
      if frame[0]==10 #ストライク
        point += 10 + frames[i+1][0] + frames[i+1][1]
      elsif  frame.sum == 10 #スペア
        point += 10 + frames[i+1][0]
      else
        point += frame.sum
      end
    when 9..11 #10ラウンド目
      point += frame.sum
    end
  end
  puts point
end

main
