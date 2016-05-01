module DataCollector
  module Exceptions
    class DataCollectorException < StandardError
      attr_accessor :context

      def initialize(msg, context = {})
        super(msg)
        @context = context
      end
    end

    class RecordNotFound          < DataCollectorException; end
    class ImageInvalidType        < DataCollectorException; end
    class DeleteNotPermited       < DataCollectorException; end
    class AwsError                < DataCollectorException; end
    class SqlExecuteError         < DataCollectorException; end
    class WrapperError            < DataCollectorException; end
    class AnswerInvalid           < DataCollectorException; end
    class KpiTreeStructureInvalid < DataCollectorException; end
    class ActivityTreeInvalid     < DataCollectorException; end
    class AccomplishmentsInvalid  < DataCollectorException; end
    class FilterInvalid           < DataCollectorException; end
  end
end
