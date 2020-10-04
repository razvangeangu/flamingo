import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { ThemeKeyType, ThemeState } from './types';
import { getThemeFromStorage } from './utils';

export const initialState: ThemeState = {
  selected: getThemeFromStorage() || 'system',
  sunset: '',
  sunrise: '',
};

const themeSlice = createSlice({
  name: 'theme',
  initialState,
  reducers: {
    changeTheme(state, action: PayloadAction<ThemeKeyType>) {
      state.selected = action.payload;
    },
    sunsetSunriseLoaded(
      state,
      action: PayloadAction<Pick<ThemeState, 'sunrise' | 'sunset'>>,
    ) {
      state.sunrise = action.payload.sunrise;
      state.sunset = action.payload.sunset;
    },
    loadSunsetSunrise(state) {
      state.sunrise = '';
      state.sunset = '';
    },
  },
});

export const actions = themeSlice.actions;
export const reducer = themeSlice.reducer;
export const themeSliceKey = themeSlice.name;
