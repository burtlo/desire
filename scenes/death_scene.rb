class Death < GameScene

  draw :score_board

  draw :villain, color: "rgba(255,0,0,1.0)", ring_color: "rgba(127,127,127,0.0)",
    outer_ring_color: "rgba(127,127,127,0.0)"

  draw :final_score, model: "metro::ui::label",
    position: (Game.center + Point.new(0,-200,0)),
    font: { size: 60 }, color: "rgba(255,255,255,0.0)", align: 'center'

  draw :quote, model: "metro::ui::label",
    text: "There are two tragedies in life. \nOne is to lose your heart's desire. \nThe other is to gain it.\n\n - George Bernard Shaw, Man and Superman",
    position: (Game.center + Point.new(0,100,0)),
    font: { size: 40 }, color: "rgba(255,255,255,0.0)", align: 'center'

  after 1.tick do

    animate :score_board, to: { alpha: 0 }, interval: 1.second

    animate :villain, to: { x_factor: 4.0, y_factor: 4.0,
                            x: Game.center.x, y: Game.center.y }, interval: 2.seconds do
      villain.body.p = CP::Vec2.new(villain.x,villain.y)

      after 2.seconds do
        animate :villain, to: { alpha: 0 }, interval: 1.second do
          animate :final_score, to: { alpha: 255 }, interval: 2.seconds do
            animate :quote, to: { alpha: 255 }, interval: 1.second do
              after 4.seconds do
                transition_to :title
              end
            end
          end
        end
      end
    end

  end

  def prepare_transition_from(old_scene)
    score_board.score = old_scene.score_board.score
    villain.position = old_scene.villain.position
    final_score.text = old_scene.score_board.score.to_i.to_s
  end

end