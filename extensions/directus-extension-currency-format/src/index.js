import { defineDisplay } from '@directus/extensions-sdk';
import DisplayComponent from './display.vue';

export default defineDisplay({
	id: 'currency-formatter',
	name: 'Currency Formatter',
	icon: 'attach_money',
	description: 'Format numbers as currency with multiple currency support',
	component: DisplayComponent,
	options: [
		{
			field: 'currency',
			name: 'Currency',
			type: 'string',
			meta: {
				width: 'half',
				interface: 'select-dropdown',
				options: {
					choices: [
						{ text: 'USD - US Dollar', value: 'USD' },
						{ text: 'EUR - Euro', value: 'EUR' },
						{ text: 'GBP - British Pound', value: 'GBP' },
						{ text: 'JPY - Japanese Yen', value: 'JPY' },
						{ text: 'VND - Vietnamese Dong', value: 'VND' },
						{ text: 'CNY - Chinese Yuan', value: 'CNY' },
						{ text: 'KRW - South Korean Won', value: 'KRW' },
						{ text: 'SGD - Singapore Dollar', value: 'SGD' },
					],
				},
			},
			schema: {
				default_value: 'USD',
			},
		},
		{
			field: 'locale',
			name: 'Locale',
			type: 'string',
			meta: {
				width: 'half',
				interface: 'select-dropdown',
				options: {
					choices: [
						{ text: 'en-US (English - US)', value: 'en-US' },
						{ text: 'en-GB (English - UK)', value: 'en-GB' },
						{ text: 'de-DE (German)', value: 'de-DE' },
						{ text: 'fr-FR (French)', value: 'fr-FR' },
						{ text: 'vi-VN (Vietnamese)', value: 'vi-VN' },
						{ text: 'ja-JP (Japanese)', value: 'ja-JP' },
						{ text: 'zh-CN (Chinese)', value: 'zh-CN' },
						{ text: 'ko-KR (Korean)', value: 'ko-KR' },
					],
				},
			},
			schema: {
				default_value: 'en-US',
			},
		},
		{
			field: 'showSymbol',
			name: 'Show Currency Symbol',
			type: 'boolean',
			meta: {
				width: 'half',
				interface: 'boolean',
			},
			schema: {
				default_value: true,
			},
		},
		{
			field: 'minimumFractionDigits',
			name: 'Minimum Decimal Places',
			type: 'integer',
			meta: {
				width: 'half',
				interface: 'input',
				options: {
					min: 0,
					max: 10,
				},
			},
			schema: {
				default_value: 2,
			},
		},
	],
	types: ['integer', 'bigInteger', 'float', 'decimal'],
});
