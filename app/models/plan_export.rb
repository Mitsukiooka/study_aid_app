require 'csv'

class PlanExport

  attr_accessor :file_encoding

  def initialize
    @file_encoding = 'sjis'
  end

  COLUMN_HEADERS = [
    '計画名',
    '使用教材',
    '計画詳細',
    '計画目標',
    '進捗状況',
    'フィードバック',
    '計画開始日',
    '計画終了日'
  ]

  def to_csv_row(plan)
    data = [
      plan.title,
      plan.study_aid,
      plan.plan_detail,
      plan.plan_goal,
      plan.status_text,
      plan.feedback_comment,
      plan.start_at,
      plan.end_at
    ]
    data = data.map{ |d| sjis_safe(d).encode(Encoding::SJIS, invalid: :replace, undef: :replace) } if file_encoding == 'sjis'
    CSV::Row.new(0..(data.size - 1), data)
  end


  def csv_headers
    column_headers = COLUMN_HEADERS
    column_headers = column_headers.map{ |d| sjis_safe(d).encode(Encoding::SJIS, invalid: :replace, undef: :replace) } if file_encoding == 'sjis'
    CSV::Row.new(1..(column_headers.size - 1), column_headers, true)
  end

  def csv_rows(plans)
    Enumerator.new do |y|
      y << csv_headers.to_s
      plans.find_each do |transaction|
        y << to_csv_row(transaction).to_s
      end
    end
  end

  # Convert special characters to sjis
  def sjis_safe(str)
    [
      ["301C", "FF5E"], # wave-dash
      ["2212", "FF0D"], # full-width minus
      ["00A2", "FFE0"], # cent as currency
      ["00A3", "FFE1"], # lb(pound) as currency
      ["00AC", "FFE2"], # not in boolean algebra
      ["2014", "2015"], # hyphen
      ["2016", "2225"], # double vertical lines
    ].inject(str) do |s, (before, after)|
      s.to_s.gsub(
        before.to_i(16).chr('UTF-8'),
        after.to_i(16).chr('UTF-8')
      )
    end
  end

  def filename
    "学習計画一覧.csv"
  end

end