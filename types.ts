export enum CalculatorAction {
  ADD = '+',
  SUBTRACT = '-',
  MULTIPLY = '×',
  DIVIDE = '÷',
  EQUALS = '=',
  CLEAR = 'AC',
  DELETE = 'DEL',
  DECIMAL = '.',
  PERCENT = '%',
  TOGGLE_SIGN = '+/-'
}

export interface HistoryItem {
  id: string;
  expression: string;
  result: string;
  timestamp: number;
}

export type Theme = 'light' | 'dark';