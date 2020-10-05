const lightTheme = {
  primary: '#0047AB',
  text: 'rgba(58,52,51,1)',
  background: 'rgba(255,255,255,1)',
};

const darkTheme: Theme = {
  primary: '#0047AB',
  text: 'rgba(241,233,231,1)',
  background: 'rgba(0,0,0, 0.95);',
};

export type Theme = typeof lightTheme;

export const themes = {
  light: lightTheme,
  dark: darkTheme,
};
