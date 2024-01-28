/** Window sizes in pixels */
export enum WINDOW_SIZES {
  small = 30,
  medium = 50,
  large = 70,
  width = 350,
}

/** Line lengths for autoexpand */
export enum LINE_LENGTHS {
  small = 36,
  medium = 73,
}

/**
 * Radio prefixes.
 * Displays the name in the left button, tags a css class.
 */
export const RADIO_PREFIXES = {
  ':r ': 'R-Ear',
  '#r ': 'R-Ear',
  '.r ': 'R-Ear',
  ':l ': 'L-Ear',
  '#l ': 'L-Ear',
  '.l ': 'L-Ear',
  ':i ': 'Intercom',
  '#i ': 'Intercom',
  '.i ': 'Intercom',
  ':h ': 'Dept',
  '#h ': 'Dept',
  '.h ': 'Dept',
  ':c ': 'Cmd',
  '#c ': 'Cmd',
  '.c ': 'Cmd',
  ':n ': 'Sci',
  '#n ': 'Sci',
  '.n ': 'Sci',
  ':m ': 'Med',
  '#m ': 'Med',
  '.m ': 'Med',
  ':x ': 'Proc',
  '#x ': 'Proc',
  '.x ': 'Proc',
  ':e ': 'Engi',
  '#e ': 'Engi',
  '.e ': 'Engi',
  ':s ': 'Sec',
  '#s ': 'Sec',
  '.s ': 'Sec',
  ':w ': 'Whisper',
  '#w ': 'Whisper',
  '.w ': 'Whisper',
  ':t ': 'Synd',
  '#t ': 'Synd',
  '.t ': 'Synd',
  ':u ': 'Supp',
  '#u ': 'Supp',
  '.u ': 'Supp',
  ':z ': 'Serv',
  '#z ': 'Serv',
  '.z ': 'Serv',
  ':p ': 'AI',
  '#p ': 'AI',
  '.p ': 'AI',
  ':$ ': 'ERT',
  '#$ ': 'ERT',
  '.$ ': 'ERT',
  ':- ': 'SpecOps',
  '#- ': 'SpecOps',
  '.- ': 'SpecOps',
  ':_ ': 'SyndTeam',
  '#_ ': 'SyndTeam',
  '._ ': 'SyndTeam',
  ':+ ': 'Special',
  '#+ ': 'Special',
  '.+ ': 'Special',
} as const;
