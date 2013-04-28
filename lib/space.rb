module Metro
  module UI
    class Space < Model

      property :damping, default: 0.5
      property :sampling_per_update, default: 6

      def delta
        @delta ||= (1.0/60.0)
      end

      attr_reader :space

      def show
        @space = CP::Space.new
        @space.damping = damping
      end

      def add_object(object)
        space_objects.push(object)
        space.add_body object.body
        space.add_shape object.shape
      end

      def space_objects
        @space_objects ||= []
      end

      def add_objects(objects)
        Array(objects).each {|object| add_object(object) }
      end

      def step
        sampling_per_update.to_i.times { space.step(delta) }
      end

      def clean_up
        space_objects.each {|object| object.body.reset_forces }
        space.rehash_static
      end

    end
  end
end
